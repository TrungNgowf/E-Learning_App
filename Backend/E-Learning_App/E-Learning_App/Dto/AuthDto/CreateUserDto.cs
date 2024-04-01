namespace E_Learning_App.Dto;

public class CreateUserDto
{
    public string FirebaseUID { get; set; }
    public int AccountTypeId { get; set; }
    public string Username { get; set; }
    public string Email { get; set; }
    public DateTime DateOfBirth { get; set; }

    public string? Avatar { get; set; }

    public int GenderId { get; set; }
    public int[] RoleIds { get; set; }
    
}