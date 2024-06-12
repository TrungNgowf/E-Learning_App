namespace E_Learning_App.Dto.CourseDto;

public class CoursePreviewForInstructor
{
    public string Title { get; set; }
    public string Description { get; set; }
    public string Author { get; set; }
    public List<string> Categories { get; set; }
    public decimal CoursePrice { get; set; }
    public string Thumbnail { get; set; }
    public string Requirements { get; set; }
    public string WhatYouWillLearn { get; set; }
    public string Includes { get; set; }
    public List<LessonDto> Lessons { get; set; }
    public long TotalDuration { get; set; }
    public DateTime CreationTime { get; set; }
}
