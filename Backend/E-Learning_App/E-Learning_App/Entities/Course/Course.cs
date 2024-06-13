using E_Learning_App.Entities.Identity;
using E_Learning_App.Entities.Profile;
using Microsoft.EntityFrameworkCore;

namespace E_Learning_App.Entities.Course;

public class Course : Entity
{
    public string Title { get; set; }
    public string Description { get; set; }
    public virtual ICollection<CourseCategory> Categories { get; set; }
    public long InstructorId { get; set; }
    public virtual Instructor Instructor { get; set; } = null!;
    [Precision(18, 2)] public decimal CoursePrice { get; set; }
    public string Thumbnail { get; set; } =
        "https://res.cloudinary.com/sofiathefck/image/upload/v1714160388/e_learning/common/course_place_holder.jpg";
    public int FollowersCount { get; set; } = 0;
    public float? CourseScore { get; set; }
    public string? Requirements { get; set; }
    public string? WhatYouWillLearn { get; set; }
    public string? Includes { get; set; }
    public virtual ICollection<Lesson> Lessons { get; set; } = new List<Lesson>();
    public ICollection<User>? LikedByUsers { get; set; } 
    public ICollection<User>? PurchasedByUsers { get; set; }
}