namespace E_Learning_App.Entities.Identity.Master;

public class Role : Entity
{
    public string EnName { get; set; }
    public virtual ICollection<User> Users { get; set; }
}

public static class RoleNames
{
    public const string Admin = "Admin";
    public const string Instructor = "Instructor";
    public const string Student = "Student";
}