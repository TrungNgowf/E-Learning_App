namespace E_Learning_App.Entities.Course;

public class CourseCategory : Entity
{
    public string Title { get; set; }
    public string Description { get; set; }
    public virtual ICollection<Course> Courses { get; set; }
}