using Microsoft.EntityFrameworkCore;
using ShoutAPI.Database.Models;
using static ShoutAPI.Database.Models.Records;

namespace ShoutAPI.Database
{
    public class DatabaseContext : DbContext
    {
        public required DbSet<TestModel> TestData { get; set; }
        public required DbSet<RegistrationRecord> Registration { get; set; }

        public DatabaseContext(DbContextOptions<DatabaseContext> dbContext) : base(dbContext) { 

        }
    }
}
