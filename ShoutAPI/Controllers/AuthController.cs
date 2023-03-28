using Microsoft.AspNetCore.Mvc;
using ShoutAPI.Services;
using static ShoutAPI.Database.Models.Records;

namespace ShoutAPI.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class AuthController : ControllerBase
    {
        private readonly AuthService _authService;

        public AuthController(AuthService aService)
        {
            _authService = aService;
        }

        [HttpPost("login")]
        public IActionResult LoginUser(LoginRecord loginData)
        {
            var validated = _authService.CheckCredentials(loginData);
            return validated switch
            {
                -1 => BadRequest("Invalid user"),
                0 => BadRequest("Invalid password"),
                1 => Ok("Success!"),
                _ => BadRequest("Unknown error"),
            };
        }

        [HttpPost("register")]
        public IActionResult RegisterUser(NewUserRecord registrationData)
        {
            // TODO: Add registration
            var userRegistered = _authService.RegisterUser(registrationData);
            return BadRequest();
        }
    }
}
