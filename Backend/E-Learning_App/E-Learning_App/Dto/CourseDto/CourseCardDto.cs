using E_Learning_App.Entities;

namespace E_Learning_App.Dto.CourseDto;

public class CourseCardDto
{
    public long Id { get; set; }
    public String Title { get; set; }
    public String Thumbnail { get; set; }
    public decimal CoursePrice { get; set; }
    public List<String> Categories { get; set; }
    public float? CourseScore { get; set; }
    public String Author { get; set; }
}