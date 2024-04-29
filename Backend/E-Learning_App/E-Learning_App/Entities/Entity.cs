using System.ComponentModel.DataAnnotations;
using System.Security.Claims;
using Microsoft.AspNetCore.Identity;

namespace E_Learning_App.Entities;

public abstract class Entity
{
    [Key]
    public long Id { get; set; }
    public DateTime CreationTime { get; set; } = DateTime.Now;
    public long CreatorId { get; set; } 
    public DateTime? LastModifiedTime { get; set; }
}