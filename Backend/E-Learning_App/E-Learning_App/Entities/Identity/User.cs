using System.ComponentModel.DataAnnotations;
using E_Learning_App.Entities.Identity.Master;

namespace E_Learning_App.Entities.Identity;

public class User : Entity
{
    public string FirebaseUID { get; set; }
    public virtual AccountType AccountType { get; set; }
    public string Username { get; set; }
    [EmailAddress] public string Email { get; set; }
    public DateTime DateOfBirth { get; set; }

    public string Avatar { get; set; } =
        "https://res.cloudinary.com/sofiathefck/image/upload/v1711822395/e_learning/common/male_default_avatar.jpg";

    public virtual ICollection<Role> Roles { get; set; }
    public string? RefreshToken { get; set; }
    public DateTime? RefreshTokenCreated { get; set; }
    public DateTime? RefreshTokenExpiry { get; set; }
    public bool IsEmailVerified { get; set; } = false;
}