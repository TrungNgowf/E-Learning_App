namespace E_Learning_App.Entities.Course;

public class Lesson : Entity
{
    public string Title { get; set; }
    public string Description { get; set; }
    public string VideoUrl { get; set; }
    public long Duration { get; set; }
    public long CourseId { get; set; }
    public virtual Course Course { get; set; } = null!;
}