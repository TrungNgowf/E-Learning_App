using E_Learning_App.Dto;
using E_Learning_App.Dto.UserDto;
using E_Learning_App.Entities;
using E_Learning_App.Entities.Identity;
using E_Learning_App.Entities.Profile;
using Riok.Mapperly.Abstractions;

namespace E_Learning_App.Helpers;

[Mapper]
public partial class AppMapper
{
    public partial User MapCreateUserDtoToUser(CreateUserDto createUserDto);
    public partial Instructor MapCreateInstructorDtoToInstructorProfile(CreateInstructorDto createInstructorDto);
}