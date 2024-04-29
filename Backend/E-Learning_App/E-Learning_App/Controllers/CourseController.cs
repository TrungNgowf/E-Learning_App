using E_Learning_App.Configuration;
using E_Learning_App.Dto.CourseDto;
using E_Learning_App.Entities.Identity.Master;
using E_Learning_App.Helpers;
using E_Learning_App.Services.UserService;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace E_Learning_App.Controllers;

[Route("[controller]/[action]")]
[ApiController]
public class CourseController(DataContext context, IUserService userService) : ControllerBase
{
    private readonly IUserService _userService = userService;
    private readonly AppMapper _mapper = new();

    [HttpGet]
    public async Task<List<CourseCategoryDto>> GetCourseCategories()
    {
        var courseCategories = await context.CourseCategory.ToListAsync();
        return courseCategories.Select(c => new CourseCategoryDto
        {
            Id = (int)c.Id,
            Title = c.Title,
            Description = c.Description
        }).OrderBy(c => c.Title).ToList();
    }
}