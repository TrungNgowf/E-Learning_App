using System.ComponentModel.DataAnnotations;

namespace E_Learning_App.Dto;

public class AuthRequestDto
{
    [EmailAddress] public required string Email { get; set; }
}