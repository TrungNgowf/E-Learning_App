using System.ComponentModel.DataAnnotations;
using E_Learning_App.Entities.Identity;

namespace E_Learning_App.Entities.Profile;

public class Instructor : Entity
{
    public string ContactInfo { get; set; }
    public string About { get; set; }
    public string Qualifications { get; set; }
    public string Experience { get; set; }
    public long UserId { get; set; }
    public virtual User User { get; set; } = null!;
    public virtual ICollection<Course.Course> Courses { get; set; } = new List<Course.Course>();
}