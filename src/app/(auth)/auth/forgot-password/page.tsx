"use client";

import { useState } from "react";
import Link from "next/link";
import { Globe, Loader2, CheckCircle2 } from "lucide-react";
import { createClient } from "@/lib/supabase/client";

export default function ForgotPasswordPage() {
  const [email, setEmail] = useState("");
  const [error, setError] = useState<string | null>(null);
  const [loading, setLoading] = useState(false);
  const [success, setSuccess] = useState(false);

  const handleReset = async (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);
    setLoading(true);

    try {
      const supabase = createClient();
      const { error } = await supabase.auth.resetPasswordForEmail(email, {
        redirectTo: `${window.location.origin}/auth/callback?next=/settings`,
      });

      if (error) {
        setError(error.message);
        return;
      }

      setSuccess(true);
    } catch {
      setError("An unexpected error occurred. Please try again.");
    } finally {
      setLoading(false);
    }
  };

  if (success) {
    return (
      <div className="space-y-6 text-center">
        <div className="flex items-center justify-center">
          <div className="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
            <CheckCircle2 className="w-6 h-6 text-primary" />
          </div>
        </div>
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Check your email</h1>
          <p className="text-sm text-muted-foreground mt-2 max-w-xs mx-auto">
            If an account exists for <strong>{email}</strong>, we&apos;ve sent
            password reset instructions.
          </p>
        </div>
        <Link
          href="/auth/login"
          className="inline-flex items-center text-sm text-primary font-medium hover:underline"
        >
          Back to sign in
        </Link>
      </div>
    );
  }

  return (
    <div className="space-y-8">
      {/* Header */}
      <div className="text-center space-y-3">
        <div className="flex items-center justify-center">
          <div className="w-12 h-12 rounded-xl bg-primary flex items-center justify-center">
            <Globe className="w-6 h-6 text-primary-foreground" />
          </div>
        </div>
        <div>
          <h1 className="text-2xl font-bold tracking-tight">Reset password</h1>
          <p className="text-sm text-muted-foreground mt-1">
            Enter your email and we&apos;ll send you reset instructions
          </p>
        </div>
      </div>

      {/* Form */}
      <form onSubmit={handleReset} className="space-y-4">
        {error && (
          <div className="bg-destructive/10 text-destructive text-sm rounded-lg px-4 py-3">
            {error}
          </div>
        )}

        <div className="space-y-2">
          <label
            htmlFor="email"
            className="text-sm font-medium text-foreground"
          >
            Email
          </label>
          <input
            id="email"
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="you@example.com"
            required
            className="w-full h-10 px-3 rounded-lg border border-input bg-background text-sm placeholder:text-muted-foreground focus:outline-none focus:ring-2 focus:ring-ring focus:ring-offset-2 focus:ring-offset-background transition-colors"
          />
        </div>

        <button
          type="submit"
          disabled={loading}
          className="w-full h-10 rounded-lg bg-primary text-primary-foreground text-sm font-medium hover:bg-primary/90 disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2 transition-colors"
        >
          {loading ? (
            <>
              <Loader2 className="w-4 h-4 animate-spin" />
              Sending...
            </>
          ) : (
            "Send Reset Instructions"
          )}
        </button>
      </form>

      {/* Footer */}
      <p className="text-center text-sm text-muted-foreground">
        Remember your password?{" "}
        <Link
          href="/auth/login"
          className="text-primary font-medium hover:underline"
        >
          Sign in
        </Link>
      </p>
    </div>
  );
}
