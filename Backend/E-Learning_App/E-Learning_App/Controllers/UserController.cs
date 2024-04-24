using E_Learning_App.Configuration;
using E_Learning_App.Entities;
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

    [HttpGet, Authorize]
    public CurrentUser GetMe()
    {
        return _userService.GetCurrentUser();
    }
}