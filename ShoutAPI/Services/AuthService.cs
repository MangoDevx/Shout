using ShoutAPI.Database;
using static ShoutAPI.Database.Models.Records;

namespace ShoutAPI.Services
{
    [RegisterScoped]
    public class AuthService
    {
        private readonly DatabaseContext _dbContext;

        public AuthService(DatabaseContext dataContext)
        {
            _dbContext = dataContext;
        }

        public int CheckCredentials(LoginRecord loginData)
        {
            var registrationTable = _dbContext.Registration;
            var user = registrationTable.FirstOrDefault(x => x.username == loginData.username);
            if (user == null)
                return -1; // Return bad username

            var validated = BCrypt.Net.BCrypt.Verify(loginData.password, user.password);
            if (validated)
                return 1; // Return success
            return 0; // Return bad password
        }

        public int RegisterUser(NewUserRecord newUser)
        {
            // TODO: Registration
            return 0;
        }
    }
}
