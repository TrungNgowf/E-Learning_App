using System.ComponentModel.DataAnnotations;

namespace E_Learning_App.Dto;

public class CreateUserDto
{
    public string FirebaseUID { get; set; }
    public int AccountTypeId { get; set; }
    public string Username { get; set; }
    [EmailAddress] public string Email { get; set; }
    public int[] RoleIds { get; set; }
}