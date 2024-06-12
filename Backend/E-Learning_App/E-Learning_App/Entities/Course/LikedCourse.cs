using E_Learning_App.Entities.Identity;

namespace E_Learning_App.Entities.Course;

public class LikedCourse : SubEntity
{
    public long UserId { get; set; }
    public User User { get; set; }

    public long CourseId { get; set; }
    public Course Course { get; set; }
    
}