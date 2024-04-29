using E_Learning_App.Entities.Course;
using E_Learning_App.Entities.Identity;
using E_Learning_App.Entities.Identity.Master;
using E_Learning_App.Entities.Profile;
using Microsoft.EntityFrameworkCore;

namespace E_Learning_App.Configuration;

public class DataContext(DbContextOptions<DataContext> options) : DbContext(options)
{
    // Identity
    public DbSet<User> User { get; set; }
    public DbSet<Role> Role { get; set; }
    public DbSet<AccountType> AccountType { get; set; }
    
    //Course
    public DbSet<Course> Course { get; set; }
    public DbSet<CourseCategory> CourseCategory { get; set; }
    public DbSet<Instructor> Instructor { get; set; }
};