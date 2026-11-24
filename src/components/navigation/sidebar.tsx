"use client";

import Link from "next/link";
import { usePathname } from "next/navigation";
import {
  Globe,
  Map,
  Plane,
  Camera,
  MapPin,
  Heart,
  BarChart3,
  Settings,
  User,
  Sun,
  Moon,
  Monitor,
  Plus,
  LogOut,
} from "lucide-react";
import { useTheme } from "next-themes";
import { cn } from "@/lib/utils";
import { createClient } from "@/lib/supabase/client";
import { useRouter } from "next/navigation";
import { useState } from "react";

const mainNavItems = [
  { href: "/dashboard", label: "Overview", icon: Globe },
  { href: "/map", label: "World Map", icon: Map },
  { href: "/trips", label: "My Trips", icon: Plane },
  { href: "/memories", label: "Memories", icon: Camera },
  { href: "/places", label: "Places", icon: MapPin },
  { href: "/bucket-list", label: "Bucket List", icon: Heart },
  { href: "/statistics", label: "Statistics", icon: BarChart3 },
];

const bottomNavItems = [
  { href: "/profile", label: "Profile", icon: User },
  { href: "/settings", label: "Settings", icon: Settings },
];

export function Sidebar() {
  const pathname = usePathname();
  const { theme, setTheme } = useTheme();
  const router = useRouter();
  const [isLoggingOut, setIsLoggingOut] = useState(false);

  const handleLogout = async () => {
    setIsLoggingOut(true);
    const supabase = createClient();
    await supabase.auth.signOut();
    router.push("/auth/login");
  };

  const cycleTheme = () => {
    if (theme === "dark") setTheme("light");
    else if (theme === "light") setTheme("system");
    else setTheme("dark");
  };

  const ThemeIcon = theme === "dark" ? Moon : theme === "light" ? Sun : Monitor;

  return (
    <aside className="hidden lg:flex flex-col w-64 h-screen bg-sidebar-background border-r border-sidebar-border fixed left-0 top-0 z-40">
      {/* Logo */}
      <div className="flex items-center gap-3 px-6 h-16 border-b border-sidebar-border">
        <div className="w-8 h-8 rounded-lg bg-primary flex items-center justify-center">
          <Globe className="w-4.5 h-4.5 text-primary-foreground" />
        </div>
        <div>
          <h1 className="text-sm font-semibold text-sidebar-foreground tracking-tight">
            MyWorld
          </h1>
          <p className="text-[10px] text-sidebar-muted leading-none">
            Your Personal World Atlas
          </p>
        </div>
      </div>

      {/* Add button */}
      <div className="px-4 mt-4">
        <Link
          href="/add"
          className="flex items-center justify-center gap-2 w-full h-9 rounded-lg bg-primary text-primary-foreground text-sm font-medium hover:bg-primary/90 transition-colors"
        >
          <Plus className="w-4 h-4" />
          Add New
        </Link>
      </div>

      {/* Main Navigation */}
      <nav className="flex-1 px-3 mt-6 space-y-1">
        <p className="px-3 mb-2 text-[10px] font-semibold uppercase tracking-widest text-sidebar-muted">
          Explore
        </p>
        {mainNavItems.map((item) => {
          const isActive = pathname === item.href || pathname.startsWith(item.href + "/");
          return (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                "flex items-center gap-3 px-3 h-9 rounded-lg text-sm font-medium transition-colors",
                isActive
                  ? "bg-sidebar-accent text-sidebar-accent-foreground"
                  : "text-sidebar-foreground/70 hover:text-sidebar-foreground hover:bg-sidebar-accent/50"
              )}
            >
              <item.icon className="w-4 h-4 shrink-0" />
              {item.label}
            </Link>
          );
        })}
      </nav>

      {/* Bottom section */}
      <div className="px-3 pb-4 space-y-1 border-t border-sidebar-border pt-3">
        {bottomNavItems.map((item) => {
          const isActive = pathname === item.href;
          return (
            <Link
              key={item.href}
              href={item.href}
              className={cn(
                "flex items-center gap-3 px-3 h-9 rounded-lg text-sm font-medium transition-colors",
                isActive
                  ? "bg-sidebar-accent text-sidebar-accent-foreground"
                  : "text-sidebar-foreground/70 hover:text-sidebar-foreground hover:bg-sidebar-accent/50"
              )}
            >
              <item.icon className="w-4 h-4 shrink-0" />
              {item.label}
            </Link>
          );
        })}

        {/* Theme toggle */}
        <button
          onClick={cycleTheme}
          className="flex items-center gap-3 px-3 h-9 rounded-lg text-sm font-medium text-sidebar-foreground/70 hover:text-sidebar-foreground hover:bg-sidebar-accent/50 transition-colors w-full"
        >
          <ThemeIcon className="w-4 h-4 shrink-0" />
          {theme === "dark" ? "Dark" : theme === "light" ? "Light" : "System"}
        </button>

        {/* Logout */}
        <button
          onClick={handleLogout}
          disabled={isLoggingOut}
          className="flex items-center gap-3 px-3 h-9 rounded-lg text-sm font-medium text-sidebar-foreground/70 hover:text-destructive hover:bg-destructive/10 transition-colors w-full"
        >
          <LogOut className="w-4 h-4 shrink-0" />
          {isLoggingOut ? "Signing out..." : "Sign Out"}
        </button>
      </div>
    </aside>
  );
}
