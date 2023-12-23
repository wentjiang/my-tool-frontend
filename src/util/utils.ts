export function getValueOrThrow(v: string | undefined, errorMessage: string) {
  if (typeof v === "string") {
    return v as string;
  }
  throw new Error(errorMessage);
}
