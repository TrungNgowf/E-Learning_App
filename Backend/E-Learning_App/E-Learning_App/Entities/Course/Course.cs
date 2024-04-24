using Microsoft.EntityFrameworkCore;

namespace E_Learning_App.Entities.Course;

public class Course : Entity
{
    public string Title { get; set; }
    public string Description { get; set; }
    [Precision(18, 2)] public decimal CoursePrice { get; set; }
    public string Thumbnail { get; set; }
    public int FollowersCount { get; set; } = 0;
    public float CourseScore { get; set; }
    public virtual CourseCategory Category { get; set; }
}