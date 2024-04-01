using E_Learning_App.Dto;
using E_Learning_App.Entities;
using E_Learning_App.Entities.Identity;
using Riok.Mapperly.Abstractions;

namespace E_Learning_App.Helpers;

[Mapper]
public partial class AppMapper
{
    public partial User MapCreateUserDtoToUser(CreateUserDto createUserDto);
}