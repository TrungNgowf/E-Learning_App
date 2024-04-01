using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using E_Learning_App.Configuration;
using E_Learning_App.Dto;
using E_Learning_App.Entities;
using E_Learning_App.Entities.Identity;
using E_Learning_App.Entities.Identity.Master;
using E_Learning_App.Helpers;
using E_Learning_App.Services.UserService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;

namespace E_Learning_App.Controllers
{
    [Route("[controller]/[action]")]
    [ApiController]
    public class AuthController : ControllerBase
    {
        private readonly IConfiguration _config;
        private readonly DataContext _context;
        private readonly IUserService _userService;
        readonly AppMapper _mapper = new();

        public AuthController(IConfiguration config, DataContext context, IUserService userService)
        {
            _config = config;
            _context = context;
            _userService = userService;
        }

        private async Task<User> Register(CreateUserDto createUserDto)
        {
            try
            {
                User user = _mapper.MapCreateUserDtoToUser(createUserDto);
                user.FirebaseUID = Guid.NewGuid().ToString();
                user.AccountType =
                    (await _context.AccountType.FirstOrDefaultAsync(accountType =>
                        accountType.Id == createUserDto.AccountTypeId)!)!;
                user.Gender =
                    (await _context.Gender.FirstOrDefaultAsync(gender => gender.Id == createUserDto.GenderId)!)!;
                ICollection<Role> roles = new List<Role>();
                foreach (var roleId in createUserDto.RoleIds)
                {
                    roles.Add((await _context.Role.FirstOrDefaultAsync(r => r.Id == roleId)!)!);
                }

                user.Roles = roles;
                _context.User.Add(user);
                await _context.SaveChangesAsync();
                return user;
            }
            catch (Exception e)
            {
                Console.WriteLine(e);
                throw;
            }
        }

        [HttpPost]
        public async Task<ActionResult> Login(CreateUserDto createUserDto)
        {
            User callbackUser;
            var currentUser =
                await _context.User
                    .FirstOrDefaultAsync(user => user.Email == createUserDto.Email)!;
            if (currentUser != null)
            {
                callbackUser = currentUser;
            }
            else
            {
                var createdUser = await Register(createUserDto);
                callbackUser = createdUser;
            }

            var token = CreateToken(callbackUser);
            var refreshToken = GenerateRefreshToken();
            SetRefreshToken(refreshToken);
            callbackUser.RefreshToken = refreshToken.Token;
            callbackUser.RefreshTokenCreated = refreshToken.CreationTime;
            callbackUser.RefreshTokenExpiry = refreshToken.ExpiredDate;
            _context.User.Update(callbackUser);
            await _context.SaveChangesAsync();
            return Ok(token);
        }

        private string CreateToken(User user)
        {
            List<Claim> claims = new List<Claim>
            {
                new(ClaimTypes.NameIdentifier, user.Id.ToString()),
                new(ClaimTypes.Name, user.Username),
                new(ClaimTypes.Email, user.Email),
            };
            foreach (var role in user.Roles)
            {
                claims.Add(new Claim(ClaimTypes.Role, role.EnName));
            }

            var key = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(_config.GetSection("AppSecrets:AccessKey").Value!));
            var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha512Signature);
            var token = new JwtSecurityToken(
                claims: claims,
                expires: DateTime.Now.AddHours(1),
                signingCredentials: creds
            );
            var tokenHandler = new JwtSecurityTokenHandler();
            return tokenHandler.WriteToken(token);
        }

        private RefreshToken GenerateRefreshToken()
        {
            var refreshToken = new RefreshToken
            {
                Token = Convert.ToBase64String(RandomNumberGenerator.GetBytes(64)),
                ExpiredDate = DateTime.Now.AddDays(7)
            };
            return refreshToken;
        }

        private void SetRefreshToken(RefreshToken refreshToken)
        {
            var cookieOptions = new CookieOptions
            {
                HttpOnly = true,
                Expires = refreshToken.ExpiredDate
            };
            Response.Cookies.Append("refreshToken", refreshToken.Token, cookieOptions);
        }

        [HttpPost, Authorize]
        public async Task<ActionResult<string>> RefreshToken()
        {
            var refreshToken = Request.Cookies["refreshToken"];
            var userId = User.FindFirstValue(ClaimTypes.NameIdentifier);
            var user = await _context.User.FirstOrDefaultAsync(u =>
                u.Id == int.Parse(userId!));
            if (!user.RefreshToken.Equals(refreshToken)) return Unauthorized("Invalid refresh token");
            if (user.RefreshTokenExpiry < DateTime.Now) return Unauthorized("Refresh token expired");
            var token = CreateToken(user);
            var newRefreshToken = GenerateRefreshToken();
            SetRefreshToken(newRefreshToken);
            user.RefreshToken = newRefreshToken.Token;
            user.RefreshTokenCreated = newRefreshToken.CreationTime;
            user.RefreshTokenExpiry = newRefreshToken.ExpiredDate;
            _context.User.Update(user);
            await _context.SaveChangesAsync();
            return Ok(token);
        }

        [HttpGet, Authorize]
        public CurrentUser GetMe()
        {
            return _userService.GetCurrentUser();
        }
    }
}