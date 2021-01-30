module.exports = {
  purge: {
    enabled: false,
    content: [
      './src/**/*.html',
      './src/**/*.elm',
      './src/**/*.js'],
  },
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {},
  },
  variants: {
    extend: {},
  },
  plugins: [
    require('@tailwindcss/typography'),
  ],
}
