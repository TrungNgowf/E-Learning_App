using System.Security.Claims;
using System.Security.Principal;
using E_Learning_App.Entities;
using E_Learning_App.Entities.Identity.Master;
using Microsoft.AspNetCore.Authorization;
using static System.Security.Principal.WindowsIdentity;

namespace E_Learning_App.Services.UserService;

public class UserService : IUserService
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public UserService(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public CurrentUser GetCurrentUser()
    {
        var currentUser = new CurrentUser();
        if (_httpContextAccessor.HttpContext != null)
        {
            currentUser.Id =
                int.Parse(_httpContextAccessor.HttpContext.User.FindFirstValue(ClaimTypes.NameIdentifier)!);
            currentUser.Username = _httpContextAccessor.HttpContext.User.FindFirstValue(ClaimTypes.Name)!;
            currentUser.Email = _httpContextAccessor.HttpContext.User.FindFirstValue(ClaimTypes.Email)!;
            currentUser.Roles = _httpContextAccessor.HttpContext.User.FindAll(ClaimTypes.Role).Select(x => x.Value)
                .ToList();
        }

        return currentUser;
    }
}