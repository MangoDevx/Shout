using System.ComponentModel.DataAnnotations;

namespace ShoutAPI.Database.Models
{
    public class Records
    {
        public record LoginRecord(string Username, string Password);
        public record NewUserRecord(string Username, string Password, string PhoneNumber, string? ClientId);

        public record RegistrationRecord
        {
            [Key]
            public Guid Id { get; set; }

            public required string Username { get; set; }
            public required string Password { get; set; }
            public required string PhoneNumber { get; set; }

            public required DateTime DateRegistered { get; init; }

            public string? ClientId { get; set; }

            public required string Salt { get; init; }

        }
    }
}
