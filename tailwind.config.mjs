/** @type {import('tailwindcss').Config} */
export default {
	content: ['./src/**/*.{astro,html,js,jsx,md,mdx,svelte,ts,tsx,vue}'],
	theme: {
		extend: {
			colors: {
				primary: '#dc0e63',
				secondary: '#f67caf',
				blanco: '#ffffff',
				negro: '#000000'
			}
		},
	},
	plugins: [],
}
