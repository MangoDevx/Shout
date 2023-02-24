using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using ShoutAPI.Database.Models;
using ShoutAPI.Services;

namespace ShoutAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class TestController : ControllerBase
    {

        private readonly TestService _testService;

        public TestController(TestService _tService)
        {
            _testService = _tService;
        }

        [HttpGet("first")]
        public IActionResult GetFirst()
        {
            try
            {
                var user = _testService.GetFirstTestEntry();
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

        [HttpGet("last")]
        public IActionResult GetLast()
        {
            try
            {
                var user = _testService.GetLastTestEntry();
                if (user != null)
                    return Ok(user);
                else
                    return BadRequest("No test user found.");
            }
            catch (Exception ex)
            {
                return StatusCode(StatusCodes.Status500InternalServerError, ex.Message);
            }
        }

        [HttpPost]
        public IActionResult Post(TestModel model) => StatusCode(_testService.AddTestEntry(model).Item1);
    }
}
