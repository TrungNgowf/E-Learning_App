using E_Learning_App.Configuration;
using E_Learning_App.Dto.UserDto;
using E_Learning_App.Entities;
using E_Learning_App.Entities.Identity.Master;
using E_Learning_App.Helpers;
using E_Learning_App.Services.UserService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace E_Learning_App.Controllers;

[Route("[controller]/[action]")]
[ApiController]
public class UserController : ControllerBase
{
    private readonly DataContext _context;
    private readonly IUserService _userService;
    private readonly AppMapper _mapper = new();

    public UserController(DataContext context, IUserService userService)
    {
        _context = context;
        _userService = userService;
    }
    
    [HttpPost, Authorize]
    public async Task UpdateToInstructor(CreateInstructorDto input)
    {
        var crtUser = _userService.GetCurrentUser();
        var user = await _context.User.Include(u=>u.Roles).FirstOrDefaultAsync(x => x.Id == crtUser.Id);
        if (user is null)
        {
            throw new Exception("User not found");
        }

        user.Username = input.FullName;
        user.Roles.Add((await _context.Role.FirstOrDefaultAsync(r => r.EnName == RoleNames.Instructor))!);
        var instructorProfile = _mapper.MapCreateInstructorDtoToInstructorProfile(input);
        user.Instructor = instructorProfile;
        await _context.SaveChangesAsync();
    }
    
    [HttpDelete, Authorize]
    public async Task DeleteInstructorProfile()
    {
        var crtUser = _userService.GetCurrentUser();
        var user = await _context.User.Include(u=>u.Roles).FirstOrDefaultAsync(x => x.Id == crtUser.Id);
        if (user is null)
        {
            throw new Exception("User not found");
        }

        user.Roles.Remove((await _context.Role.FirstOrDefaultAsync(r => r.EnName == RoleNames.Instructor))!);
        user.Instructor = null;
        await _context.SaveChangesAsync();
    }
    
    [HttpGet, Authorize(Roles = RoleNames.Student)]
    public async Task<decimal> GetAccountBalance()
    {
        var crtUser = _userService.GetCurrentUser();
        var user = await _context.User.FirstOrDefaultAsync(x => x.Id == crtUser.Id);
        if (user is null)
        {
            throw new Exception("User not found");
        }
        return user.AccountBalance;
    }
}