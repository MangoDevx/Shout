using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoutAPI.Database;
using ShoutAPI.Database.Models;
using System.Net;

namespace ShoutAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TestController : ControllerBase
    {

        private DatabaseContext dbContext { get; set; }

        public TestController(DatabaseContext dbContext)
        {
            this.dbContext = dbContext;
        }

        [HttpGet]
        public IActionResult Get()
        {
            try
            {
                var user = dbContext.TestData.FirstOrDefault();
                if (user != null)
                    return Ok(user);
                else
                    return BadRequest("No test user found.");
            }
            catch(Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public IActionResult Post(TestModel model)
        {
            try
            {
                var newUser = new TestModel { DateAdded = DateTime.UtcNow.ToString(), EntryName = model.EntryName, RandomBool = model.EntryName.Length < 8 };
                dbContext.TestData.Add(newUser);
                dbContext.SaveChanges();
                if (dbContext.TestData.Contains(newUser))
                    return Ok("New user added");
                else
                    return BadRequest("Failed to add user.");
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, ex.Message);
            }

        }
    }
}
