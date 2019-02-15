using api.Business;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace api.Tests
{
    [TestClass]
    public class ReservationTests
    {
        [TestMethod]
        public void CanMakeReservation_IsUserAdmin_ReturnsTrue()
        {
            // Arrange
            var reservation = new Reservation();

            // Act
            var result = reservation.CanMakeReservation(new User() { Role = 1 });

            Assert.IsTrue(result);
        }
    }
}
