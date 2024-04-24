using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace E_Learning_App.Migrations
{
    /// <inheritdoc />
    public partial class RemoveOrderCourse : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Order",
                table: "CourseCategory");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "Order",
                table: "CourseCategory",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }
    }
}
