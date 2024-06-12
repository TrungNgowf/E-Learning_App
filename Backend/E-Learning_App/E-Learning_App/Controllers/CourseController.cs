using E_Learning_App.Configuration;
using E_Learning_App.Dto.CourseDto;
using E_Learning_App.Entities.Course;
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

    [HttpGet, Authorize(Roles = RoleNames.Instructor)]
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

    [HttpPost, Authorize(Roles = RoleNames.Instructor)]
    public async Task<IActionResult> CreateCourse(CreateCourseDto createCourseDto)
    {
        try
        {
            var user = _userService.GetCurrentUser();
            var course = _mapper.MapCreateCourseDtoToCourse(createCourseDto);
            course.Instructor = (await context.Instructor.FirstOrDefaultAsync(i => i.UserId == user.Id))!;
            course.Categories = await context.CourseCategory
                .Where(c => createCourseDto.CategoriesId.Contains((int)c.Id)).ToListAsync();
            course.Lessons = createCourseDto.Lessons.Select(l => new Lesson
            {
                Title = l.Title,
                Description = l.Description,
                VideoUrl = l.VideoUrl,
                Duration = l.Duration
            }).ToList();
            course.CreatorId = user.Id ?? 0;
            context.Course.Add(course);
            await context.SaveChangesAsync();
            return Ok();
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            throw;
        }
    }

    [HttpGet, Authorize(Roles = RoleNames.Instructor)]
    public async Task<List<CourseItemForInstructorView>> GetCoursesForInstructor()
    {
        try
        {
            var crtUser = _userService.GetCurrentUser();
            var instructor = await context.Instructor
                .Include(i => i.Courses).ThenInclude(c => c.Categories)
                .FirstOrDefaultAsync(i => i.UserId == crtUser.Id);
            var coursesIns = instructor!.Courses.OrderByDescending(u => u.CreationTime).Select(i =>
                new CourseItemForInstructorView
                {
                    Id = i.Id,
                    Title = i.Title,
                    Thumbnail = i.Thumbnail,
                    CoursePrice = i.CoursePrice,
                    CreationTime = i.CreationTime,
                    Categories = i.Categories.Select(c => c.Title).ToList()
                });
            return coursesIns.ToList();
        }
        catch (Exception e)
        {
            Console.WriteLine(e);
            throw;
        }
    }

    [HttpGet, Authorize(Roles = RoleNames.Instructor)]
    public async Task<CoursePreviewForInstructor> GetCoursePreviewForInstructor(long courseId)
    {
        var crtUser = _userService.GetCurrentUser();
        var course = await context.Course.Include(a => a.Instructor).ThenInclude(u => u.User)
            .Include(c => c.Lessons).Include(course => course.Categories)
            .FirstOrDefaultAsync(c => c.Id == courseId);
        if (course == null) return null!;
        var coursePreview = new CoursePreviewForInstructor
        {
            Title = course!.Title,
            Description = course.Description,
            Author = course.Instructor.User.Username,
            Categories = course.Categories.Select(c => c.Title).ToList(),
            CoursePrice = course.CoursePrice,
            Thumbnail = course.Thumbnail,
            Requirements = course.Requirements,
            WhatYouWillLearn = course.WhatYouWillLearn,
            Includes = course.Includes,
            Lessons = course.Lessons.Select(l => new LessonDto
            {
                Title = l.Title,
                Description = l.Description,
                VideoUrl = l.VideoUrl,
                Duration = l.Duration
            }).ToList(),
            TotalDuration = course.Lessons.Sum(l => l.Duration),
            CreationTime = course.CreationTime 
        };
        return coursePreview;
    }
}