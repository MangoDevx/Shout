using System.ComponentModel.DataAnnotations;

namespace ShoutAPI.Database.Models
{
    public class TestModel
    {
        [Key]
        public long Key { get; set; }

        public string? DateAdded { get; set; }
        public required string EntryName { get; set; }
        public bool RandomBool { get; set; }
    }
}
