namespace E_Learning_App.Dto.CourseDto;

public class CourseDetail
{
    public long Id { get; set; }
    public string Title { get; set; }
    public string Description { get; set; }
    public AuthorDto Author { get; set; }
    public List<string> Categories { get; set; }
    public decimal CoursePrice { get; set; }
    public string Thumbnail { get; set; }
    public string Requirements { get; set; }
    public string WhatYouWillLearn { get; set; }
    public string Includes { get; set; }
    public List<LessonDto> Lessons { get; set; }
    public long TotalDuration { get; set; }
    public DateTime CreationTime { get; set; }
    public bool IsPurchased { get; set; }
    public bool IsLiked { get; set; }
}
public class AuthorDto
{
    public long Id { get; set; }
    public string Name { get; set; }
    public string ProfilePicture { get; set; }
    public string ContactInfo{ get; set; }
    public int TotalCourses { get; set; }
    
}
