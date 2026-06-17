import { Link } from 'react-router-dom';
import NavLinks from './NavLinks';
import { IoArrowBackOutline } from 'react-icons/io5';
import { useAuthStore } from '../../../store/authStore';

export default function Sidebar() {
    const user = useAuthStore((state) => state.user);

    return (
        <div className="flex h-full w-full flex-col px-3 py-4 md:px-2 bg-white">
            <Link
                to="/"
                className="mb-2 flex h-16 md:h-40 items-center md:items-end justify-center md:justify-start rounded-2xl md:bg-primary p-4 md:shadow-sm transition-all shrink-0"
            >
                <div className="flex items-center gap-2">
                    <img
                        src="/LogoIcon.svg"
                        alt="Logo"
                        className="w-8 h-8 md:brightness-0 md:invert transition-all"
                    />
                    <span className="text-lg md:text-xl font-black text-text-primary md:text-white tracking-tight">
                        Akiel
                    </span>
                </div>
            </Link>

            <div className="flex grow flex-row justify-between items-center space-x-2 md:flex-col md:items-stretch md:space-x-0 md:space-y-2">
                
                <NavLinks />

                <div className="hidden h-auto w-full rounded-xl bg-gray-50 grow md:block"></div>

                <Link
                    to={`/profile/${user?.id}`}
                    className="flex h-14 grow items-center justify-center gap-3 rounded-xl text-sm font-medium bg-gray-50 hover:bg-gray-100 hover:text-primary md:flex-none md:justify-start md:p-3 transition-all shrink-0"
                >
                    {/* User Avatar */}
                    <div className="w-7 h-7 md:w-9 md:h-9 rounded-full bg-white overflow-hidden shrink-0 border border-gray-200">
                        <img
                            src={user?.profile_pic?.url || `https://ui-avatars.com/api/?name=${user?.fullname || 'Admin'}`}
                            alt="Profile"
                            className="w-full h-full object-cover"
                        />
                    </div>

                    <div className="hidden md:block overflow-hidden">
                        <p className="text-xs font-bold text-text-primary truncate leading-tight">
                            {user?.fullname || "Admin Name"}
                        </p>
                        <div className="flex items-center gap-1 text-text-secondary mt-0.5">
                            <IoArrowBackOutline size={10} />
                            <span className="text-[9px] font-medium uppercase tracking-wider">Back to Profile</span>
                        </div>
                    </div>

                </Link>
            </div>
        </div>
    );
}