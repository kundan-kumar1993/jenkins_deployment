using System;

namespace api.Business
{
    public class Reservation
    {
        public bool CanMakeReservation(User user)
        {
            if (user.Role == 1)
            {
                return true;
            }
            return false;
        }
        
    }

    public class User
    {
        public int Role { get; set; }
    }
}
