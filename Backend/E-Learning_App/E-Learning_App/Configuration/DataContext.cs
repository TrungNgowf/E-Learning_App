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
    public DbSet<Lesson> Lesson { get; set; }
    public DbSet<LikedCourse> LikedCourse { get; set; }
    public DbSet<PurchasedCourse> PurchasedCourse { get; set; }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);

        modelBuilder.Entity<User>()
            .HasMany(u => u.LikedCourses)
            .WithMany(r => r.LikedByUsers)
            .UsingEntity<LikedCourse>(
                j => j.HasOne<Course>()
                    .WithMany().OnDelete(DeleteBehavior.Restrict)
                    .HasForeignKey(l => l.CourseId),
                j => j.HasOne<User>()
                    .WithMany().OnDelete(DeleteBehavior.Restrict)
                    .HasForeignKey(l => l.UserId),
                j => j.HasKey(l => new { l.UserId, l.CourseId }));
        modelBuilder.Entity<User>()
            .HasMany(u => u.PurchasedCourses)
            .WithMany(r => r.PurchasedByUsers)
            .UsingEntity<PurchasedCourse>(
                j => j.HasOne<Course>()
                    .WithMany().OnDelete(DeleteBehavior.Restrict)
                    .HasForeignKey(l => l.CourseId),
                j => j.HasOne<User>()
                    .WithMany().OnDelete(DeleteBehavior.Restrict)
                    .HasForeignKey(l => l.UserId),
                j => j.HasKey(l => new { l.UserId, l.CourseId }));
    }
};