using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ShoutAPI.Migrations
{
    /// <inheritdoc />
    public partial class Updatedloginrecords : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.AddColumn<string>(
                name: "phoneNumber",
                table: "Registration",
                type: "text",
                nullable: false,
                defaultValue: "");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "phoneNumber",
                table: "Registration");
        }
    }
}
