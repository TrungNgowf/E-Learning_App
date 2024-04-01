namespace E_Learning_App.Entities;

public class RefreshToken
{
    public required string Token { get; set; }
    public required DateTime ExpiredDate { get; set; }
    public DateTime CreationTime { get; set; } = DateTime.Now;
}