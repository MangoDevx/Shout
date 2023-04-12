using Microsoft.EntityFrameworkCore;
using static ShoutAPI.Database.Models.Records;

namespace ShoutAPI.Database
{
    public class DatabaseContext : DbContext
    {
        public required DbSet<RegistrationRecord> Registration { get; set; }

        public DatabaseContext(DbContextOptions<DatabaseContext> dbContext) : base(dbContext) { 

        }
    }
}
