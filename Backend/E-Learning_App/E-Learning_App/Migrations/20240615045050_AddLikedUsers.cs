using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace E_Learning_App.Migrations
{
    /// <inheritdoc />
    public partial class AddLikedUsers : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "FollowersCount",
                table: "Course");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<int>(
                name: "FollowersCount",
                table: "Course",
                type: "int",
                nullable: false,
                defaultValue: 0);
        }
    }
}
