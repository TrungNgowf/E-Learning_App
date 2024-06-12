using E_Learning_App.Entities.Identity.Master;

namespace E_Learning_App.Entities;

public class CurrentUser
{
    public long? Id { get; set; }
    public string Username { get; set; }
    public string Email { get; set; }
    public List<string> Roles { get; set; }
}