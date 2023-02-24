using Microsoft.EntityFrameworkCore;
using ShoutAPI.Database.Models;

namespace ShoutAPI.Database
{
    public class DatabaseContext : DbContext
    {
        public required DbSet<TestModel> TestData { get; set; }

        public DatabaseContext(DbContextOptions<DatabaseContext> dbContext) : base(dbContext) { 

        }
    }
}
