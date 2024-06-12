namespace E_Learning_App.Entities;

public abstract class SubEntity
{
    public DateTime CreationTime { get; set; } = DateTime.Now;
    public long CreatorId { get; set; } 
    public DateTime? LastModifiedTime { get; set; }
}