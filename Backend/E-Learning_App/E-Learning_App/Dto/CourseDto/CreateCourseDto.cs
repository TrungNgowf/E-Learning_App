namespace E_Learning_App.Dto.CourseDto;

public class CreateCourseDto
{
    public string Title { get; set; }
    public string Description { get; set; }
    public List<int> CategoriesId { get; set; }
    public decimal CoursePrice { get; set; }
    public string Thumbnail { get; set; }
    public string Requirements { get; set; }
    public string WhatYouWillLearn { get; set; }
    public string Includes { get; set; }
    public List<LessonDto> Lessons { get; set; }
}

public class LessonDto
{
    public string Title { get; set; }
    public string Description { get; set; }
    public string VideoUrl { get; set; }
    public long Duration { get; set; }
}