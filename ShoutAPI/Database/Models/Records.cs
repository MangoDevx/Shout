using System.ComponentModel.DataAnnotations;

namespace ShoutAPI.Database.Models
{
    public class Records
    {
        public record LoginRecord(string username, string password);
        public record NewUserRecord(string username, string password, string phoneNumber, string? clientId);
        public record RegistrationRecord([property:Key]Guid id, string username, string password, string phoneNumber, DateTime dateRegistered, string? clientId, string salt);
    }
}
