namespace E_Learning_App.Dto;

public class AuthResponseDto
{
    public required long UserId { get; set; }
    public required string FirebaseUID { get; set; }
    public required string Username { get; set; }
    public required string Email { get; set; }
    public required string AccessToken { get; set; }
    public required string RefreshToken { get; set; }
    public required List<string> Roles { get; set; }
}