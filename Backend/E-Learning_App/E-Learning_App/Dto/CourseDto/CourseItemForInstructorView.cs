namespace E_Learning_App.Dto.CourseDto;

public class CourseItemForInstructorView
{
    public long Id { get; set; }
    public string Title { get; set; }
    public string Thumbnail { get; set; }
    public DateTime CreationTime { get; set; }
    public decimal CoursePrice { get; set; }
    public List<string> Categories { get; set; }
}