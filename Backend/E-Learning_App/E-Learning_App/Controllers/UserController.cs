using E_Learning_App.Configuration;
using E_Learning_App.Helpers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace E_Learning_App.Controllers;

[Route("[controller]/[action]")]
[ApiController]
public class UserController(DataContext context) : ControllerBase
{
    private readonly DataContext _context = context;
    private readonly AppMapper _mapper = new();

    [HttpGet]
    public async Task<ActionResult> GetUsers()
    {
        try
        {
            var users = await _context.User.ToListAsync();
            return Ok(users);
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            throw;
        }
    }

    [HttpGet("{id}")]
    public async Task<ActionResult> GetUser(int id)
    {
        try
        {
            var user = await _context.User.FirstOrDefaultAsync(u => u.Id == id);
            return Ok(user);
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            throw;
        }
    }
    
}