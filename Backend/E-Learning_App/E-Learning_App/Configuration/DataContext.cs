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


        modelBuilder.Entity<LikedCourse>()
            .HasKey(lc => new { lc.UserId, lc.CourseId });

        modelBuilder.Entity<LikedCourse>()
            .HasOne(lc => lc.User)
            .WithMany(u => u.LikedCourses)
            .HasForeignKey(lc => lc.UserId)
            .OnDelete(DeleteBehavior.NoAction);

        modelBuilder.Entity<LikedCourse>()
            .HasOne(lc => lc.Course)
            .WithMany(c => c.LikedByUsers)
            .HasForeignKey(lc => lc.CourseId)
            .OnDelete(DeleteBehavior.NoAction);

        modelBuilder.Entity<PurchasedCourse>()
            .HasKey(pc => new { pc.UserId, pc.CourseId });

        modelBuilder.Entity<PurchasedCourse>()
            .HasOne(pc => pc.User)
            .WithMany(u => u.PurchasedCourses)
            .HasForeignKey(pc => pc.UserId)
            .OnDelete(DeleteBehavior.NoAction);

        modelBuilder.Entity<PurchasedCourse>()
            .HasOne(pc => pc.Course)
            .WithMany(c => c.PurchasedByUsers)
            .HasForeignKey(pc => pc.CourseId)
            .OnDelete(DeleteBehavior.NoAction);
    }
};