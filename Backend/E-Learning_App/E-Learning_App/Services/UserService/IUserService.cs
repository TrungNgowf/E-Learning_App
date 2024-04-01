using E_Learning_App.Entities;

namespace E_Learning_App.Services.UserService;

public interface IUserService
{
    CurrentUser GetCurrentUser();
}