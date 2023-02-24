using Microsoft.AspNetCore.Mvc;
using ShoutAPI.Database;
using ShoutAPI.Database.Models;

namespace ShoutAPI.Services
{
    [RegisterScoped]
    public class TestService
    {

        private readonly DatabaseContext _dbContext;

        public TestService(DatabaseContext dataContext)
        {
            _dbContext = dataContext;
        }

        public TestModel? GetFirstTestEntry()
        {
            return _dbContext.TestData.FirstOrDefault();
        }

        public TestModel? GetLastTestEntry()
        {
            return _dbContext.TestData.LastOrDefault();
        }

        public IEnumerable<TestModel?> GetTestEntries() {
            return _dbContext.TestData;
        }

        public (int, string) AddTestEntry(TestModel entry)
        {
            if(entry is null)
                return (StatusCodes.Status400BadRequest, "Entry was null.");

            try
            {
                var newUser = new TestModel { DateAdded = DateTime.UtcNow.ToString(), EntryName = entry.EntryName, RandomBool = entry.EntryName.Length < 8 };
                _dbContext.TestData.Add(newUser);
                _dbContext.SaveChanges();
                return (StatusCodes.Status200OK, "Successfully added entry.");
            }
            catch (Exception ex)
            {
                return (StatusCodes.Status500InternalServerError, ex.Message);
            }
        }
    }
}
