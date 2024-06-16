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

    [HttpGet, Authorize(Roles = RoleNames.Student)]
    public async Task<List<CourseCardDto>> GetCoursesPreviewForHomePage(int type)
    {
        var courses = type switch
        {
            0 => context.Course.Include(c => c.Instructor)
                .ThenInclude(i => i.User)
                .Include(c => c.Categories)
                .OrderByDescending(c => c.CourseScore)
                .Take(8),
            1 => context.Course.Include(c => c.Instructor)
                .ThenInclude(i => i.User)
                .Include(c => c.Categories)
                .Include(c => c.LikedByUsers)
                .OrderByDescending(c => c.LikedByUsers.Count)
                .Take(8),
            2 => context.Course.Include(c => c.Instructor)
                .ThenInclude(i => i.User)
                .Include(c => c.Categories)
                .OrderByDescending(c => c.CreationTime)
                .Take(8),
            _ => context.Course.Include(c => c.Instructor)
                .ThenInclude(i => i.User)
                .Include(c => c.Categories)
                .OrderByDescending(c => c.CreationTime)
                .Take(8),
        };
        var courseDto = await courses.Select(c => new CourseCardDto
        {
            Id = c.Id,
            Title = c.Title,
            Thumbnail = c.Thumbnail,
            CoursePrice = c.CoursePrice,
            Categories = c.Categories.Select(cat => cat.Title).ToList(),
            CourseScore = c.CourseScore,
            Author = c.Instructor.User.Username
        }).ToListAsync();
        return courseDto;
    }

    [HttpGet, Authorize(Roles = RoleNames.Student)]
    public async Task<CourseDetail> GetCourseDetail(long courseId)
    {
        var crtUser = _userService.GetCurrentUser();
        var course = await context.Course.Include(a => a.Instructor).ThenInclude(u => u.User)
            .Include(c => c.Lessons).Include(course => course.Categories)
            .Include(course => course.Instructor).ThenInclude(instructor => instructor.Courses)
            .Include(course => course.PurchasedByUsers).Include(course => course.LikedByUsers)
            .FirstOrDefaultAsync(c => c.Id == courseId);
        if (course == null) return null!;
        var courseDetail = new CourseDetail
        {
            Id = course.Id,
            Title = course!.Title,
            Description = course.Description,
            Author = new AuthorDto
            {
                Id = course.Instructor.Id,
                Name = course.Instructor.User.Username,
                ProfilePicture = course.Instructor.User.Avatar,
                ContactInfo = course.Instructor.ContactInfo,
                TotalCourses = course.Instructor.Courses.Count
            },
            Categories = course.Categories.Select(c => c.Title).ToList(),
            CoursePrice = course.CoursePrice,
            Thumbnail = course.Thumbnail,
            Requirements = course.Requirements!,
            WhatYouWillLearn = course.WhatYouWillLearn!,
            Includes = course.Includes!,
            Lessons = course.Lessons.Select(l => new LessonDto
            {
                Title = l.Title,
                Description = l.Description,
                VideoUrl = l.VideoUrl,
                Duration = l.Duration
            }).ToList(),
            TotalDuration = course.Lessons.Sum(l => l.Duration),
            CreationTime = course.CreationTime,
            IsPurchased = course.PurchasedByUsers.Any(u => u.Id == crtUser.Id),
            IsLiked = course.LikedByUsers.Any(u => u.Id == crtUser.Id)
        };
        return courseDetail;
    }

    [HttpPost, Authorize(Roles = RoleNames.Student)]
    public async Task<IActionResult> LikeCourse(long courseId)
    {
        var crtUser = _userService.GetCurrentUser();
        var course = await context.Course.Include(c => c.LikedByUsers).FirstOrDefaultAsync(c => c.Id == courseId);
        if (course == null) return NotFound();
        if (course.LikedByUsers.Any(u => u.Id == crtUser.Id)) return BadRequest("You have already liked this course");
        var user = await context.User.FirstOrDefaultAsync(u => u.Id == crtUser.Id);
        if (user != null) course.LikedByUsers.Add(user);
        await context.SaveChangesAsync();
        return Ok();
    }

    [HttpPost, Authorize(Roles = RoleNames.Student)]
    public async Task<IActionResult> UnLikeCourse(long courseId)
    {
        var crtUser = _userService.GetCurrentUser();
        var course = await context.Course.Include(c => c.LikedByUsers).FirstOrDefaultAsync(c => c.Id == courseId);
        if (course == null) return NotFound();
        var user = await context.User.FirstOrDefaultAsync(u => u.Id == crtUser.Id);
        if (user != null) course.LikedByUsers.Remove(user);
        await context.SaveChangesAsync();
        return Ok();
    }


    [HttpPost, Authorize(Roles = RoleNames.Student)]
    public async Task<IActionResult> PurchaseCourse(long courseId)
    {
        var crtUser = _userService.GetCurrentUser();
        var user = await context.User.FirstOrDefaultAsync(u => u.Id == crtUser.Id);
        var course = await context.Course.Include(c => c.PurchasedByUsers).FirstOrDefaultAsync(c => c.Id == courseId);
        if (course == null) return NotFound();
        if (course.PurchasedByUsers.Any(u => u.Id == crtUser.Id))
            return BadRequest("You have already purchased this course");
        if (user!.AccountBalance < course.CoursePrice)
            return BadRequest("You don't have enough money to purchase this course");
        user.AccountBalance -= course.CoursePrice;
        course.PurchasedByUsers.Add(user!);
        await context.SaveChangesAsync();
        return Ok();
    }

    [HttpGet, Authorize(Roles = RoleNames.Student)]
    public async Task<List<EnrolledCourseCard>> GetEnrolledCourses()
    {
        var crtUser = _userService.GetCurrentUser();
        var user = await context.User.Include(u => u.PurchasedCourses).ThenInclude(ec => ec.Categories)
            .Include(user => user.PurchasedCourses).ThenInclude(course => course.Instructor)
            .ThenInclude(ins => ins.User)
            .FirstOrDefaultAsync(u => u.Id == crtUser.Id);
        if (user == null) return null!;
        var enrolledCourses = user.PurchasedCourses.OrderByDescending(o => o.CreationTime)
            .Select(ec => new EnrolledCourseCard
            {
                Id = ec.Id,
                Title = ec.Title,
                Thumbnail = ec.Thumbnail,
                CoursePrice = ec.CoursePrice,
                Categories = ec.Categories.Select(c => c.Title).ToList(),
                Author = ec.Instructor.User.Username,
                CreationTime = ec.CreationTime
            }).ToList();
        return enrolledCourses;
    }

    [HttpGet, Authorize(Roles = RoleNames.Student)]
    public async Task<List<EnrolledCourseCard>> GetLikedCourses()
    {
        var crtUser = _userService.GetCurrentUser();
        var user = await context.User.Include(u => u.LikedCourses).ThenInclude(ec => ec.Categories)
            .Include(user => user.LikedCourses).ThenInclude(course => course.Instructor).ThenInclude(ins => ins.User)
            .FirstOrDefaultAsync(u => u.Id == crtUser.Id);
        if (user == null) return null!;
        var likedCourses = user.LikedCourses.OrderByDescending(o => o.CreationTime)
            .Select(ec => new EnrolledCourseCard
            {
                Id = ec.Id,
                Title = ec.Title,
                Thumbnail = ec.Thumbnail,
                CoursePrice = ec.CoursePrice,
                Categories = ec.Categories.Select(c => c.Title).ToList(),
                Author = ec.Instructor.User.Username,
                CreationTime = ec.CreationTime
            }).ToList();
        return likedCourses;
    }
}